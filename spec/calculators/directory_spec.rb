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
      it { expect(subject.directory_sizes).to eq(file_data_root) }
    end
    context 'when file_data is complete' do
      let(:file_data) { file_data_all_levels }
      it { expect(subject.directory_sizes).to eq(file_data_all_levels) }
    end
  end

end
# rubocop:enable Style/NumericLiterals
# rubocop:enable Metrics/BlockLength
