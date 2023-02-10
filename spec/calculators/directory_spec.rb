# frozen_string_literal: true

require_relative '../../lib/calculators/directory'

# rubocop:disable Metrics/BlockLength
# rubocop:disable Style/NumericLiterals
describe Calculators::Directory do
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
      let(:file_data) { file_data_root }
      it { expect(subject.directory_sizes).to eq({}) }
    end
    context 'when file_data is complete' do
      let(:file_data) { file_data_all_levels }
      it { expect(subject.directory_sizes).to eq({}) }
    end
  end

  # intermediate step - useful for debugging
  describe '#paths' do
    before { subject.run }

    context 'root' do
      let(:file_data) { { '/' => {} } }
      let(:expected_result) { ['/'] }

      it { expect(subject.paths).to match_array(expected_result) }
    end

    context 'nested 1 level' do
      let(:file_data) { { '/' => { 'a' => {} } } }
      let(:expected_result) { ['/', '/a'] }

      it { expect(subject.paths).to match_array(expected_result) }
    end

    context 'nested 2 level' do
      let(:file_data) do
        { '/' =>
          { 'a' => { 'b' => {} },
            'c' => { 'd' => {} } } }
      end
      let(:expected_result) { ['/', '/a', '/c', '/a/b', '/c/d'] }

      it { expect(subject.paths).to match_array(expected_result) }
    end

    context 'full data set' do
      let(:file_data) { file_data_all_levels}
      let(:expected_result) do
        ['/', '/a', '/d', '/a/e']
      end

      it { expect(subject.paths).to match_array(expected_result) }
    end
  end
end
# rubocop:enable Style/NumericLiterals
# rubocop:enable Metrics/BlockLength
