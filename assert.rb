class AssertionNotRaising < StandardError; end
class AssertionRaised < StandardError; end
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

def assert_not_raise(&expectation)
  begin
    expectation.call
  rescue StandardError => e
    raise AssertionRaised.new("Wasn't expecting an exception but #{e} was raised.")
  end
end


# a partir daqui, temos testes! :)

class OmgError < StandardError; end
assert_raise(AssertionNotRaising) { assert_raise(OmgError) {} }
assert_raise(AssertionRaised) {
  assert_not_raise { raise OmgError.new }
}

assert_not_raise { assert true }
assert_raise(AssertionError) { assert false }
assert_raise(AssertionError) { assert "4:20" }
