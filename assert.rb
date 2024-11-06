class AssertionNotRaising < StandardError; end
class AssertionError < StandardError; end

def assert(expectation)
  raise AssertionError.new if true != expectation
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
