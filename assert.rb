class AssertionNotRaising < StandardError
  def initialize(error_expected)
    super "Expected #{error_expected} to be raised, but it wasn't"
  end
end

class AssertionError < StandardError; end

def assert_raise(error_type, &expectation)
  begin
    expectation.call

    # Se a execução chegou aqui é sinal que nenhuma exceção foi lançada pelo
    # bloco, logo podemos considerar que o teste falhou.
    raise AssertionNotRaising.new error_type
  rescue error_type
    # Nada a fazer, significa que o teste passou porque a execução da
    # expectation lançou a exceção esperada.
  end
end

def assert_not_raise(&expectation)
end

def assert(expectation)
  raise AssertionError if !expectation
end

# daqui em diante tudo é teste :)

class NadaConstaError < StandardError; end
assert_raise(NadaConstaError) { raise NadaConstaError.new }

assert_raise(AssertionError) do
  assert_not_raise { raise NadaConstaError.new }
end

assert_raise(AssertionError) { assert false }
