RSpec.describe "`import-issues import` command", type: :cli do
  it "executes `import-issues help import` command successfully" do
    output = `import-issues help import`
    expected_output = <<-OUT
Usage:
  import-issues import

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
