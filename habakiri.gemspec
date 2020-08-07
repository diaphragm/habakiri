require_relative 'lib/habakiri/version'

Gem::Specification.new do |spec|
  spec.name          = 'habakiri'
  spec.version       = Habakiri::VERSION
  spec.authors       = ['diaphragm']
  spec.email         = ['7163746+diaphragm@users.noreply.github.com']

  spec.summary       = 'Strings template match engine'
  spec.description   = <<~EOS
    Habariki is a template match engine for strings that can extract part of text by template keywords.
  EOS
  spec.homepage      = 'https://github.com/diaphragm/habakiri'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0") - Dir['.*']
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'diff-lcs', '~> 1.4'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rubocop', '~> 0.89'
  spec.add_development_dependency 'minitest', '~> 5.14'
end
