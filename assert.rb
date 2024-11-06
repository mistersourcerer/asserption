class AssertionNotRaising < StandardError; end
class AssertionError < StandardError; end

def assert(expectation)
  raise AssertionError.new if true != expectation
end

def assert_raise(error, &expectation)
end


# a partir daqui, temos testes! :)

assert true

begin
  assert false

  raise AssertionNotRaising.new
rescue AssertionError
  # Nada a fazer, `AssertionError` é o que queremos ver aqui! :)
  # significa que o teste passou.
end

begin
  assert "4:20"

  raise AssertionNotRaising.new
rescue AssertionError
  # Nada a fazer, `AssertionError` é o que queremos ver aqui! :)
  # significa que o teste passou.
end

class OmgError < StandardError; end

begin
  assert_raise(OmgError) {  }

  raise AssertionError.new("Esperava exceção OmgError, mas nada consta! :(")
rescue AssertionNotRaising
  # Nada a fazer, `AssertionError` é o que queremos ver aqui! :)
  # significa que o teste passou.
end
