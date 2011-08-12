# encoding: utf-8
require 'spore/middleware'

class Spore
  class Middleware 
    class UserAgent < Spore::Middleware

      def expected_params
        [ :useragent ]
      end

      def process_request(env)
        env['spore.request_headers'] << { 
          :name => "User-Agent", 
          :value => self.useragent 
        }
        return nil
      end

      def process_response(resp, env)
        resp
      end

    end
  end 
end
