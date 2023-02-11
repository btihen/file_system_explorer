# Answers:

## Sum of small directories sizes

| 1989474 | Total size of small directories |

## Small directories (size <= 100K):

List Small directories (size <= 100K):

| Size | Path |
|------|------|
| 99117 | /cwdpn/mnm/rtpjd/pnrbvd |
| 36586 | /cwdpn/nmsvc/jtqgbwhb/bjnvmpc/dbglngc/hbfbvdr |
| 78854 | /cwdpn/nmsvc/jtqgbwhb/bjnvmpc/dbglngc/tlsd |
| 28086 | /cwdpn/nmsvc/jtqgbwhb/fmtpwm/ggpctlh/rdmgrtzl |
| 26615 | /cwdpn/nmsvc/ltqjb/qjgbt/vjrdcjbr/swvlpql/lqrf |
| 19020 | /cwdpn/nmsvc/ltqjb/rstzf/bjnvmpc/mtctn/nfb/bqjczmcr |
| 78642 | /cwdpn/nmsvc/ltqjb/rstzf/bjnvmpc/rjcpn/llpmvt/bhdpfpb |
| 74258 | /cwdpn/nmsvc/ltqjb/rstzf/fwmvpthq/llpmvt/bgvjb/gjtj |
| 40100 | /cwdpn/nmsvc/ltqjb/rstzf/fwmvpthq/pnrbvd/nmsvc |
| 40626 | /cwdpn/nmsvc/ltqjb/rstzf/mpz/gdfwttff |
| 69007 | /cwdpn/nmsvc/ltqjb/rstzf/mpz/njptwz |
| 69007 | /cwdpn/nmsvc/ltqjb/rstzf/mpz/njptwz/jstfcllw |
| 9887 | /cwdpn/nmsvc/ltqjb/rstzf/rmrngqdg/wvg/hlwjtqzj |
| 80522 | /fqflwvh/jzwwgjh |
| 34834 | /fqflwvh/nfh/bfj/bzrfbfp |
| 68732 | /fqflwvh/nfh/bfj/pnrbvd |
| 91779 | /fqflwvh/nfh/bfj/rbq |
| 72389 | /fqflwvh/nfh/qhn/fsgn/hjgphwdc |
| 45034 | /fqflwvh/nfh/qhn/svzhc/hpp/pwg |
| 54358 | /fqflwvh/nfh/qhn/vblpsfqz |
| 43707 | /jstfcllw/fnnjdr/bjnvmpc/ftlf |
| 43707 | /jstfcllw/fnnjdr/bjnvmpc/ftlf/rrdzzgtg |
| 94962 | /jstfcllw/fnnjdr/bjnvmpc/rhzsnr/jstfcllw/fcbs |
| 94962 | /jstfcllw/fnnjdr/bjnvmpc/rhzsnr/jstfcllw/fcbs/qtsrhfv |
| 57871 | /jstfcllw/fnnjdr/bjnvmpc/rhzsnr/llpmvt/gdjshcz |
| 39334 | /jstfcllw/fnnjdr/bjnvmpc/rhzsnr/sbsqrg |
| 44873 | /jstfcllw/fnnjdr/llpmvt/zgt |
| 89993 | /jstfcllw/lpbrvhw/pszldqqh |
| 30250 | /jstfcllw/pnrbvd/jsnfn |
| 92102 | /lhltq/wwvlv |
| 48099 | /lhltq/wwvlv/jstfcllw |
| 97940 | /tgmt |
| 94221 | /wcbq/bjnvmpc/hrjjrrvl |
| 1989474 | Total size of small directories |


# Solution Approach

Thanks for the interesting puzzle.  That was an enjoyable 'kata' that enjoys some points.

I started by reading the README to understand the goal.  Identifying directoryies with a small amount of data (with the calculation 'rules' provided. Then finding the total space these 'small' directories consume.

My process was to take 'small' steps toward the end goal.  (Which fit my time since this was mostly done evenings after work).

I started with reading the file (since I the whole problem requires processing the data) and thinking about what was needed.  I realized I could read the file line by line the only 'state' needed would be the current path.

Given the importance of the 'path' and 'names' (files or directories).  I felt the best ruby data structure for both clarity and processing ease would be a hash - as it represents similar nesting as a file-structure and can store names and either a path or a 'size' as a value.

Now I started to code - building the data parser.  I took the approach of taking the sample data in the README and building the code step by step.  This made it easy to write tests and create expected input and results.  I did this in a simple very proceedural class - basically get to green strategy.

Once that code was 'feature' complete, I then took a step back and refactored it into 2 main concepts - Command Processing and Data Processing.  This helped since these parse into two different sets of data.  This also allowed me to simplify the big 'if' into two method calls.

Then I noticed that these two concepts still had logic inside case statements.  This seemed perfect for creating duck-classes that could handel the processing with a simple case statement.  I took this one step further since I prefer when easy to make the code open for extension and closed for change and turned the class factory with case statements into a dynamic class picker with a little meta-code.  (A little more obscure but very easy to extend).

Once the data structure was successfully build by the 'parser' - started on the 'data-processing' or 'calculators' part of the code.

I thought about what was needed and how to approach this.  I settled on first being able to identify all the paths and then I could associate all the paths with a calculated 'size'.  I realized pretty quickly I would need recursion - a lot like 'rails' deeply-nested methods.

Before starting the 'calculations' I realized I needed a central class that could coordinate between the parsing and calculations.  So I build the 'file_system_explorer'.  This was straight forward and those specs simple to quasi 'system' tests.

I started with a simple 'calculator' class.  And with a little help from the Internet / StackOverflow - settled on finding all the path end-points and then I could parse these into all the possbile paths.

Once starting the 'paths-calculator', again, I build the actually code with successive specs starting with simple file_structures and successesively building the code that accomodates all the complexity and delivering all the expected 'paths'.

Once this was completed I started the 'size-calculator' - initially, these were all within the same class, but that quickly became annoying.  So I separated these into two classes - so I could engage in the logic of one problem at a time.

Again, I followed the same TDD strategy of sending simple and then progressivly complexer data structures and ensuring I get the expected results.

Once the 'size' calculator was completed, I then reorganized the class dependencies to the current form.  Since I decided probably the 'consumer' of this data would only be interested in the data structure 'for sanity checks' and curriousity and of course the directory sizes and I would allow the 'consumer / user' process / filter / summarize the data independly - which is written in the 'answer_code.rb' file.

I realized one recurrent aspect of the code where a helper module could have been helpful to avoid lots of repeaded code - with the'overloaded' - path-separator '/' and root-path location '/'. In the end I decided to submit the code as it is in its current form to respect the - submit quickly. But will explore adding as part of the 'kata' aspect for myself.

Thanks for the interesting kata.  Even if you have other candidates you prefer, this kata has been helpful (at my current company I am responsible for collecting and recommending 'katas' so we get better at evolving our designs and discuss what makes good design for our product goals).

PS - Most steps described here can be followed witht the commits - as I tried to be disciplined about commiting with each 'green' cycle and then add new features or refactor to a better design.
