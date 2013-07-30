# case class Success[T] (result : T, next : Input) extends ParseResult[T]
# abstract class NoSuccess(msg: String, next: Input) extends ParseResult[Nothing]
# case class Failure (msg : String, next : Input) extends NoSuccess (msg, next)
# case class Error (msg : String, next : Input) extends NoSuccess (msg, next)



module OMeta

  def self.success(result,tail)
    Success.new(result,tail)
  end

  def self.failure(msg,tail)
    Failure.new(msg,tail)
  end

  def self.error(msg,tail)
    Error.new(msg,tail)
  end


  class ParseResult


  end

  class Success < ParseResult


    def initialize(result,tail)
      @result = result
      @tail = tail

    end


  end



  class NoSuccess < ParseResult

  end

  class Failure < ParseResult

  end


  class Error < ParseResult

    def initialize(msg,tail)
    end

  end

end



# abstract class Parser[T] extends super.Parser[T] {
#     def or(right:Parser[T]):Parser[T] = {
#         val left = this
#         new Parser[T] {
#             def apply(in:Input) =
#                 left(in) match {
#                     case s:Success[T] => s
#                     case _            => right(in)
#             }
#         }
#     }
# }

class Parser

  def or(right)
    left = self
    ->(input){
      r = left[input]
      if r.success?
        return r
      else
        right[input]
      end

    }
  end
end
