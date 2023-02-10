# frozen_string_literal: true

require_relative '../../lib/calculators/directory_sizes'

# rubocop:disable Metrics/BlockLength
# rubocop:disable Style/NumericLiterals
describe Calculators::DirectorySizes do
  subject { described_class.new(file_data) }
  let(:file_data_root) { { '/' => {} } }
  let(:file_data_all_levels) do
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

  describe '.new' do
    context 'when file_data is empty' do
      let(:file_data) { { '/' => {} } }
      it { expect(subject.directory_sizes).to eq([]) }
    end

    context 'when file_data is 2 levels empty' do
      let(:file_data) { { '/' => { 'a' => {} } } }
      it { expect(subject.directory_sizes).to eq([]) }
    end

    context 'when file_data is complete' do
      let(:file_data) { file_data_all_levels }
      it { expect(subject.directory_sizes).to eq([]) }
    end
  end

  describe '#directory_sizes' do
    before { subject.run }

    context 'empty root' do
      let(:file_data) { { '/' => {} } }
      let(:expected_data) { [{ '/' => 0 }] }

      it { expect(subject.directory_sizes).to match_array(expected_data) }
    end

    context 'empty - root with one level' do
      let(:file_data) { { '/' => { 'a' => {} } } }
      let(:expected_data) { [{ '/' => 0 }, { '/a' => 0 }] }

      it { expect(subject.directory_sizes).to match_array(expected_data) }
    end

    context 'one level with files' do
      let(:file_data) { { '/' => { 'b.txt' => 14848514, 'c.dat' => 8504156 } } }
      let(:expected_data) { [{ '/' => 23352670 }] }

      it { expect(subject.directory_sizes).to match_array(expected_data) }
    end

    context 'one level with and without files' do
      let(:file_data) { { '/' => { 'a' => {}, 'b.txt' => 14848514, 'c.dat' => 8504156 } } }
      let(:expected_data) do
        [{ '/' => 23352670 },
         { '/a' => 0 }]
      end

      it { expect(subject.directory_sizes).to match_array(expected_data) }
    end

    context 'two levels with and without files' do
      let(:file_data) do
        { '/' => { 'a' => {}, 'b.txt' => 14848514, 'c.dat' => 8504156, 'd' => { 'e' => 1024, 'f' => 256 } } }
      end
      let(:expected_data) do
        [{ '/' => (14848514 + 8504156 + 1024 + 256) },
         { '/a' => 0 },
         { '/d' => (1024 + 256) }]
      end

      it { expect(subject.directory_sizes).to match_array(expected_data) }
    end

    context 'full data set' do
      let(:file_data) { file_data_all_levels }
      let(:expected_sizes) do
        [{ '/' => (584 + 29116 + 2557 + 62596 + 14848514 + 8504156 + 4060174 + 8033020 + 5626152 + 7214296) },
         { '/a' => (584 + 29116 + 2557 + 62596) },
         { '/a/e' => 584 },
         { '/d' => (4060174 + 8033020 + 5626152 + 7214296) }]
      end

      it { expect(subject.directory_sizes).to eq(expected_sizes) }
    end
  end
end
# rubocop:enable Style/NumericLiterals
# rubocop:enable Metrics/BlockLength
