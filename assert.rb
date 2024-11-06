class AssertionNotRaising < StandardError; end
class AssertionError < StandardError; end

def assert(expectation)
  raise AssertionError.new if true != expectation
end

def assert_raise(error, &expectation)
  begin
    expectation.call

    # Se nenhum erro foi lançado após a execução no bloco,
    # significa que a expectation falhou, pois deveria lançar.
    raise AssertionNotRaising.new
  rescue error
    # Se o erro específico esperado foi lançado, então a expectiva é válida :)
  end
end


# a partir daqui, temos testes! :)

class OmgError < StandardError; end

begin
  assert_raise(OmgError) {  }

  raise AssertionError.new("Esperava exceção OmgError, mas nada consta! :(")
rescue AssertionNotRaising
  # Nada a fazer, `AssertionError` é o que queremos ver aqui! :)
  # significa que o teste passou.
end

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
