require 'spec_helper'

RSpec.describe ScriptUtils do
  describe '#run' do
    def run(*args)
      ScriptUtils.run(*args)
    end

    context 'when output is true' do
      it 'should run the system cmd' do
        expect(ScriptUtils).to receive(:system).once.with('ls')
        run('ls', output: true)
      end
    end
  end
end
