class AssertionNotRaising < StandardError; end

def assert(expectation)

end


# a partir daqui, temos testes! :)

assert true

begin
  assert false

  raise AssertionNotRaising.new
end
