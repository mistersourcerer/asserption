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
assert_raise(AssertionNotRaising) { assert_raise(OmgError) {} }

assert true
assert_raise(AssertionError) { assert false }
assert_raise(AssertionError) { assert "4:20" }
