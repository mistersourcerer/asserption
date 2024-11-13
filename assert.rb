def assert_raise(error_type, &expectation)
  expectation.call
end

class NadaConstaError < StandardError; end
assert_raise(NadaConstaError) { raise NadaConstaError }
