require 'import/issues/commands/import'

RSpec.describe Import::Issues::Commands::Import do
  it "executes `import` command successfully" do
    output = StringIO.new
    options = {}
    command = Import::Issues::Commands::Import.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
