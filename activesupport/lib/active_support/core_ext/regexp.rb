class Regexp #:nodoc:
  def number_of_captures
    Regexp.new("|#{source}").match('').captures.length
  end

  def multiline?
    options & MULTILINE == MULTILINE
  end

  class << self
    def optionalize(pattern)
      case unoptionalize(pattern)
        when /\A(.|\(.*\))\Z/ then "#{pattern}?"
        else "(?:#{pattern})?"
      end
    end

    def unoptionalize(pattern)
      [/\A\(\?:(.*)\)\?\Z/, /\A(.|\(.*\))\?\Z/].each do |regexp|
        return $1 if regexp =~ pattern
      end
      return pattern
    end
  end
end
