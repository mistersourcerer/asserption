class AssertionNotRaising < StandardError; end

def assert_raise(error_type, &expectation)
  begin
    expectation.call

    # Se a execução chegou aqui é sinal que nenhuma exceção foi lançada pelo
    # bloco, logo podemos considerar que o teste falhou.
    raise AssertionNotRaising.new
  rescue error_type
    # Nada a fazer, significa que o teste passou porque a execução da
    # expectation lançou a exceção esperada.
  end
end

class NadaConstaError < StandardError; end
assert_raise(NadaConstaError) {}
