require_relative 'result'
module OMeta2


  class Parser < Proc

    def self.from_proc(p)
      new(&p)
    end

    def initialize(&block)
      super(&block)
    end


    def or(right)
      left = self
      Parser.new do |input|
        result = left[input]
        if result.success?
          return result
        else
          right[input]
        end
      end
    end



    def repeat
    end

  end



  class CharParser < Parser

    def initialize(expected)
      f = ->(input){
        c  = in.first
        if c == expected
          Success(c, in.rest)
        else
          Failure("Expected #{expected} got #{c}", input)
        end
      end

    end

  end

end




#   def charParser(expected:Char) = new Parser[Char] {
#     def apply(in:Input):ParseResult[Char] = {
#         val c = in.first
#         if (c == expected) Success(c, in.rest)
#         else               Failure("Expected '" + expected + "' got '" + c + "'", in)
#     }
# }


#  def repeat[T](p:Parser[T]) = new Parser[List[T]] {
#     def apply(in:Input):Success[List[T]] = {
#         //apply the given Parser
#         p (in) match {
#             //if that succeeded, recurse and prepend the result
#             case Success(t, next) => val s = apply(next)
#                                      Success(t::s.get, s.next)
#             //if it failed, end recursion and return the empty list
#             case _                => Success(Nil, in)
#         }
#     }
# }
