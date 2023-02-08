require_relative '../lib/input_parser.rb'

describe InputParser do
  subject { described_class.new(test_file) }

  let(:test_file) { 'data/test_input.txt' }

  describe ".new" do
    it { expect(subject.current_path).to eq('') }
    it { expect(subject.file_structure).to eq({}) }
  end

  describe "#run" do
    context 'when input cd /' do
      let(:test_file) { 'data/test_cd_root.txt' }

      before { subject.run }

      it { expect(subject.current_path).to eq('/') }
      it { expect(subject.file_structure).to eq({'/' => {}}) }
    end

    context 'when input cd /; ls' do
      let(:test_file) { 'data/test_cd_root_ls.txt' }
      let(:expected_structure) {
        {'/' =>
          {'a' => {},
           'b.txt' => 14848514,
           'c.dat' => 8504156,
           'd' => {},
          }
        }
      }

      before { subject.run }

      it { expect(subject.current_path).to eq('/') }
      it { expect(subject.file_structure).to eq(expected_structure) }
    end

    context 'when input cd /; ls, cd a; ls' do
      let(:test_file) { 'data/test_root_a.txt' }
      let(:expected_structure) {
        {'/' =>
          { 'a' => {
              'e' => {},
              'f' => 29116,
              'g' => 2557,
              'h.lst' => 62596,
            },
            'b.txt' => 14848514,
            'c.dat' => 8504156,
            'd' => {},
          }
        }
      }

      before { subject.run }

      it { expect(subject.current_path).to eq('/a') }
      it { expect(subject.file_structure).to eq(expected_structure) }
    end

    context 'when input cd /; ls, cd a; ls, cd e; ls' do
      let(:test_file) { 'data/test_root_a_e.txt' }
      let(:expected_structure) {
        {'/' =>
          { 'a' => {
              'e' => {'i' => 584},
              'f' => 29116,
              'g' => 2557,
              'h.lst' => 62596,
            },
            'b.txt' => 14848514,
            'c.dat' => 8504156,
            'd' => {},
          }
        }
      }

      before { subject.run }

      it { expect(subject.current_path).to eq('/a/e') }
      it { expect(subject.file_structure).to eq(expected_structure) }
    end

    context 'when input cd /; ls, cd a; ls, cd e; ls; cd ..; cd ..; cd d; ls' do
      let(:test_file) { 'data/test_all_commands.txt' }
      let(:expected_structure) {
        {'/' =>
          { 'a' => {
              'e' => {'i' => 584},
              'f' => 29116,
              'g' => 2557,
              'h.lst' => 62596,
            },
            'b.txt' => 14848514,
            'c.dat' => 8504156,
            'd' => {
              'j' => 4060174,
              'd.log' => 8033020,
              'd.ext' => 5626152,
              'k' => 7214296,
            },
          }
        }
      }

      before { subject.run }

      it { expect(subject.current_path).to eq('/d') }
      it { expect(subject.file_structure).to eq(expected_structure) }
    end
  end
end
