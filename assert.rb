class AssertionNotRaising < StandardError
  def initialize(error_expected)
    super "Expected #{error_expected} to be raised, but it wasn't"
  end
end

class AssertionRaisingError < StandardError
  def initialize(expected, raised)
    super "Expected #{expected.name} to be raised, but was #{raised.class} instead"
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
  rescue StandardError => e
    raise AssertionRaisingError.new error_type, e
  end
end

def assert_not_raise(&expectation)
  begin
    expectation.call
  rescue StandardError
    raise AssertionError.new
  end
end

def assert(expectation)
  raise AssertionError if !expectation
end

# daqui em diante tudo é teste :)

if ARGV[0] == "tests"
  puts "testing..."

  class NadaConstaError < StandardError; end
  class VasoRuimError < StandardError; end

  # Garante que um bloco lança um exceção específica
  assert_raise(NadaConstaError) { raise NadaConstaError.new }

  # Garante ser possível verificar que um bloco NÃO lança exceção
  assert_raise(AssertionError) do
    assert_not_raise { raise NadaConstaError.new }
  end

  assert_raise(AssertionRaisingError) do
    assert_raise(NadaConstaError) { raise VasoRuimError }
  end

  # Garante que assert lança exceções para expecativas de valor `falsey`
  assert_raise(AssertionError) { assert false }
  assert_raise(AssertionError) { assert nil }

  # Garante que assert NÃO lança exceções se expecativas são `truthy`
  assert_not_raise { assert true }
  assert_not_raise { assert "yes" }
end
