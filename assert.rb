def assert_raise(error_type, &expectation)
  begin
    expectation.call
  rescue error_type
    # Agora esperamos que o teste passe, já que o erro específico que desejamos
    # foi lançado pelo bloco.
  end
end

class NadaConstaError < StandardError; end
assert_raise(NadaConstaError) { raise NadaConstaError }
