class Shortener::TokenGenerator
  MAX_ATTEMPTS = 3

  class << self
    # when a block is given it'll try to generate an acceptable token (block returning true) until reaching the max attempts
    # otherwise it will return the token generated without confirm
    def generate(max_attempts: MAX_ATTEMPTS, &block)
      check_max_attempts!(max_attempts -= 1)
      
      generate_new_token.tap do |new_token|
        return new_token unless block_given?

        new_token_accepted = yield new_token
        return new_token if new_token_accepted
      end

      return generate(max_attempts: max_attempts - 1, &block)
    end

    private

    def check_max_attempts!(max_attempts)
      return unless max_attempts < 0

      raise Shortener::MaxAttemptException, "could not generate a token, reached the limit of #{MAX_ATTEMPTS} attempts"
    end

    def generate_new_token
      # the same used by ActiveRecord::SecureToken
      SecureRandom.base58(6)
    end
  end
end
