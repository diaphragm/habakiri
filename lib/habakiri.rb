require 'habakiri/version'
require 'diff/lcs'

class Habakiri
  def initialize(template, prefix = '{{', suffix = '}}')
    @prefix = prefix.to_s
    @suffix = suffix.to_s
    @template = template.to_s
    @keywords = keywords
  end

  def exec(text)
    diffs = Diff::LCS.sdiff(@template, text.to_s)

    @keywords.each.with_object({}){|(key, key_begin, key_end), object|
      index_begin = diffs.index{|d| d.old_position == key_begin }
      index_end = diffs.index{|d| d.old_position == key_end }
      list = diffs[index_begin...index_end]

      # 改行後の追加要素も対応する文字列とみなす
      i = index_end
      if i
        loop do
          diff = diffs[i]
          if diff && (diff.action == '+' || (diff.action == '=' && /\R/.match?(diff.old_element)))
            list.push(diff)
            i += 1
          else
            break
          end
        end
      end

      value = list.map(&:new_element).join.strip
      case object[key]
      when nil
        object[key] = value
      when String
        object[key] = [object[key], value]
      when Array
        object[key] << value
      end
    }
  end

  private

  def keywords
    @template.to_enum(:scan, /#{@prefix}.+?#{@suffix}/).map{
      m = Regexp.last_match
      key = m[0].delete_prefix(@prefix).delete_suffix(@suffix).strip
      [key, m.begin(0), m.end(0)]
    }
  end

  class << self
    def exec(template, text)
      new(template).exec(text)
    end
  end
end
