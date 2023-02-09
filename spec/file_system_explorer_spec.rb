# frozen_string_literal: true

require_relative '../lib/file_system_explorer'

# rubocop:disable Metrics/BlockLength
describe FileSystemExplorer do
  subject { described_class.new(test_file) }

  let(:test_file) { 'data/test_input.txt' }

  describe '.new' do
    it { expect(subject.file_structure).to eq({ '/' => {} }) }
  end

  # rubocop:disable Style/NumericLiterals
  describe '#run' do
    context 'when test_input file' do
      let(:test_file) { 'data/test_all_commands.txt' }
      let(:expected_structure) do
        { '/' =>
          { 'a' => {
              'e' => {
                'i' => 584
              },
              'f' => 29116,
              'g' => 2557,
              'h.lst' => 62596
            },
            'b.txt' => 14848514,
            'c.dat' => 8504156,
            'd' => {
              'j' => 4_060_174,
              'd.log' => 8033020,
              'd.ext' => 5626152,
              'k' => 7214296
            } } }
      end

      before { subject.run }

      it { expect(subject.file_structure).to eq(expected_structure) }
    end
  end
  # rubocop:enable Style/NumericLiterals
end
# rubocop:enable Metrics/BlockLength
