require 'habakiri/version'
require 'diff/lcs'

class Habakiri
  def initialize(prefix = '{{', suffix = '}}')
    @prefix = prefix
    @suffix = suffix
  end

  def exec(template, text)
    diffs = Diff::LCS.sdiff(template.to_s, text.to_s)
    matches = template.to_enum(:scan, /#{@prefix}.+?#{@suffix}/).map{ Regexp.last_match }

    matches.each.with_object({}){|match, object|
      start = match.begin(0)
      last = match.end(0)
      range = start...last
      list = diffs.select{|d| range.include?(d.old_position) }

      # 改行後の追加要素も対応する文字列とみなす
      i = diffs.index{|d| d.old_position == last }
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

      key = match[0].delete_prefix(@prefix).delete_suffix(@suffix).chomp
      object[key] = list.map(&:new_element).join.strip
    }
  end

  class << self
    def exec(template, text)
      new.exec(template, text)
    end
  end
end
