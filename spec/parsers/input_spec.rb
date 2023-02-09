# frozen_string_literal: true

require_relative '../../lib/parsers/input'

# rubocop:disable Metrics/BlockLength
describe Parsers::Input do
  subject { described_class.new(test_file) }

  describe '.new' do
    let(:test_file) { 'data/test_input.txt' }

    it { expect(subject.current_path).to eq('') }
    it { expect(subject.file_structure).to eq({ '/' => {} }) }
  end

  # rubocop:disable Style/NumericLiterals
  describe '#run' do
    before { subject.run }

    context 'when input cd /' do
      let(:test_file) { 'data/test_cd_root.txt' }

      it { expect(subject.current_path).to eq('/') }
      it { expect(subject.file_structure).to eq({ '/' => {} }) }
    end

    context 'when input cd /; ls' do
      let(:test_file) { 'data/test_cd_root_ls.txt' }
      let(:expected_structure) do
        { '/' =>
          { 'a' => {},
            'b.txt' => 14848514,
            'c.dat' => 8504156,
            'd' => {} } }
      end

      it { expect(subject.current_path).to eq('/') }
      it { expect(subject.file_structure).to eq(expected_structure) }
    end

    context 'when input cd /; ls, cd a; ls' do
      let(:test_file) { 'data/test_root_a.txt' }
      let(:expected_structure) do
        { '/' =>
          { 'a' => {
              'e' => {},
              'f' => 29116,
              'g' => 2557,
              'h.lst' => 62596
            },
            'b.txt' => 14848514,
            'c.dat' => 8504156,
            'd' => {} } }
      end

      it { expect(subject.current_path).to eq('/a') }
      it { expect(subject.file_structure).to eq(expected_structure) }
    end

    context 'when input cd /; ls, cd a; ls, cd e; ls' do
      let(:test_file) { 'data/test_root_a_e.txt' }
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
            'd' => {} } }
      end

      it { expect(subject.current_path).to eq('/a/e') }
      it { expect(subject.file_structure).to eq(expected_structure) }
    end

    context 'when input cd /; ls, cd a; ls, cd e; ls; cd ..; cd ..; cd d; ls' do
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
              'j' => 4060174,
              'd.log' => 8033020,
              'd.ext' => 5626152,
              'k' => 7214296
            } } }
      end

      it { expect(subject.current_path).to eq('/') }
      it { expect(subject.file_structure).to eq(expected_structure) }
    end
  end
  # rubocop:enable Style/NumericLiterals
end
# rubocop:enable Metrics/BlockLength
