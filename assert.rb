class AssertionNotRaising < StandardError; end

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

class NadaConstaError < StandardError; end
assert_raise(NadaConstaError) { raise NadaConstaError }

assert_raise(NadaConstaError) {}
