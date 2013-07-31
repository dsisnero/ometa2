# case class Success[T] (result : T, next : Input) extends ParseResult[T]
# abstract class NoSuccess(msg: String, next: Input) extends ParseResult[Nothing]
# case class Failure (msg : String, next : Input) extends NoSuccess (msg, next)
# case class Error (msg : String, next : Input) extends NoSuccess (msg, next)
sealed abstract class ParseResult[+T] {
    /** Functional composition of ParseResults.
     *
     * @param f the function to be lifted over this result
     * @return `f` applied to the result of this `ParseResult`, packaged up as a new `ParseResult`
     */
    def map[U](f: T => U): ParseResult[U]

    /** Partial functional composition of ParseResults.
     *
     * @param f the partial function to be lifted over this result
     * @param error a function that takes the same argument as `f` and
     *        produces an error message to explain why `f` wasn't applicable
     *        (it is called when this is the case)
     * @return if `f` f is defined at the result in this `ParseResult`, `f`
     *         applied to the result of this `ParseResult`, packaged up as
     *         a new `ParseResult`. If `f` is not defined, `Failure`.
     */
    def mapPartial[U](f: PartialFunction[T, U], error: T => String): ParseResult[U]

    def flatMapWithNext[U](f: T => Input => ParseResult[U]): ParseResult[U]

    def filterWithError(p: T => Boolean, error: T => String, position: Input): ParseResult[T]

    def append[U >: T](a: => ParseResult[U]): ParseResult[U]

    def isEmpty = !successful

    /** Returns the embedded result. */
    def get: T

    def getOrElse[B >: T](default: => B): B =
        if (isEmpty) default else this.get

    val next: Input

    val successful: Boolean
  }
require 'monadic/monad'
require 'abstract_type'
module OMeta2

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

     include AbstractType

     def self.unit(value)
      return value if value.is_a? Either
      return Nothing                  if value.is_a? Nothing
      return Success.new(value.fetch) if value.is_a? Just
      return Failure.new(value)       if value.nil? || (value.respond_to?(:empty?) && value.empty?) || !value
      return Success.new(value)
    end


    abstract_method :get

    def empty?
      !success?
    end


    def get_or_else(default)
      empty?  ? default : get
    end

      # Allows privileged access to the +Either+'s inner value from within a block.
    # This block should return a +Success+ or +Failure+ itself. It will be coerced into #Either
    # @return [Success, Failure]
    def bind(proc=nil, &block)
      return self if failure?
      return concat(proc) if proc.is_a? Either

      begin
        Either(call(proc, block))
      rescue StandardError => error
        Failure(error)
      end
    end


    def bind(proc = nil, &block)
    end

    def self.unit(result,tail)
      return Success.new(value.fetch, rest) if value.is_a? Success
    end

  end


   def map[U](f: T => U) = Success(f(result), next)
    def mapPartial[U](f: PartialFunction[T, U], error: T => String): ParseResult[U]
       = if(f.isDefinedAt(result)) Success(f(result), next)
         else Failure(error(result), next)

    def flatMapWithNext[U](f: T => Input => ParseResult[U]): ParseResult[U]
      = f(result)(next)

    def filterWithError(p: T => Boolean, error: T => String, position: Input): ParseResult[T] =
      if (p(result)) this
      else Failure(error(result), position)

    def append[U >: T](a: => ParseResult[U]): ParseResult[U] = this

    def get: T = result

    /** The toString method of a Success. */
    override def toString = "["+next.pos+"] parsed: "+result

    val successful = true
  }

  class Success < ParseResult


    def initialize(result,tail)
      @result = result
      @tail = tail

    end

    def flatmap_with_next(next,proc=nil,&block)
      block[result][rest]
    end


    def map(&block)
      Success.new(
    end

    def success?
      true
    end

    def to_s
      "[#{next.pos}] parsed: #{result}"
    end

  end



  class NoSuccess < ParseResult

  end

  class Failure < ParseResult

    def success?
      false
    end

  end


  class Error < ParseResult

    def initialize(msg,tail)
    end

    def success?
      false
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
