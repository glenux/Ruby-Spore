# encoding: utf-8
require 'spore/middleware'

class Spore ; class Middleware 
	class Cache < Spore::Middleware

		CACHE_USED = 'sporex.cache.used'
		REQUEST_PATH = 'spore.request_path'

		class UnsupportedStorage < Exception ; end

		# Storage parameter must respond at least to the same interface as the
		# Enumerable mixin plus [] and []= methods.
		# Thus, you could simply pass a hash to this class :-)
		def expected_params
			[ :storage ]
		end

		def process_request(env)
			env[CACHE_USED] = false
			key = env[REQUEST_PATH]

			# If cache containts request && cache is fresh
			if self.storage.include? key then
				# get response from cache
				env[CACHE_USED] = true
				resp = HTTP::Message.new_response ""
				return resp
			else
				# really make the request
				env[CACHE_USED] = false
				return nil
			end
		end

		def process_response(resp, env)
			key = env[REQUEST_PATH]
			if not env[CACHE_USED] then
				# store to cache
				self.storage[key] = resp
			end
			return resp
		end

	end
end ; end
