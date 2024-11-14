class AssertionNotRaising < StandardError; end
class AssertionRaising < StandardError; end
class AssertionError < StandardError; end

def assert_raise(error_type, &expectation)
  begin
    expectation.call

    # se chegarmos aqui, significa que o bloco não lançou o erro do tipo
    # específico `error_type`. Significa que o teste falhou.
    raise AssertionNotRaising
  rescue error_type
    # Agora esperamos que o teste passe, já que o erro específico que desejamos
    # foi lançado pelo bloco.
  end
end

def assert_not_raise(&expectation)
  begin
    expectation.call
  rescue StandardError
    # se chegou aqui o teste está falhando, pois nenhum erro deveria subir.
    raise AssertionRaising
  end
end

def assert(expectation)
  raise AssertionError
end

class NadaConstaError < StandardError; end
assert_raise(NadaConstaError) { raise NadaConstaError }
assert_raise(AssertionNotRaising) do
  assert_raise(NadaConstaError) {}
end

assert_raise(AssertionRaising) do
  assert_not_raise { raise NadaConstaError }
end
assert_not_raise {}

assert_raise(AssertionError) { assert 13 == 420 }
assert_not_raise { assert 1 == 1 }
