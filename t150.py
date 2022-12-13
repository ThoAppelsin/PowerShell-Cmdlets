

# 20220601, author Murat Ozyurt
# Question tester for pre-grading check during exam.
# The tests feed the necessary input to your executable similar to the grading process.

# Value of the "executable_file" variable must match to the specified executable in TCAdmin
# Students or candidates should not modify this file, otherwise, compilation problems may occur during grading.

# Instructors can add as many tests as they need.
# In each testX() function, the test number, input lines and expected output lines must be returned.
# Be careful with the use of """ at the end of input and expected output:
# Terminating """ of the expected output has to be placed on a separate line,
# whereas the terminating """ of the input has to be placed on the same line as the last input line.

# Some students return the expected value without any calculation, so it is a better practice
# to avoid using these test values among the actual grading test cases.  Modified versions of this file
# can be bundled with the question for the students to use during exam and project development.

"""
https://stackoverflow.com/questions/13332268/how-to-use-subprocess-command-with-pipes

ps = subprocess.Popen(('ps', '-A'), stdout=subprocess.PIPE)
output = subprocess.check_output(('grep', 'process_name'), stdin=ps.stdout)
ps.wait()
"""

import subprocess
import sys
import inspect
import importlib.util
import sys
from pathlib import Path


def runtest(executable_file, test_data, cwd):
    # Instructors need not change this method, if you do please let us know.
    command = [sys.executable, executable_file]

    test_num = test_data[0]
    input_to_test = test_data[1]
    expected_output = test_data[2].rstrip()

    p = subprocess.Popen(command, stdout=subprocess.PIPE, stdin=subprocess.PIPE, cwd=cwd)

    #out, err = p.communicate(b"10\nsecondinput")
    out, err = p.communicate(bytes(input_to_test.encode("utf-8")))
    answer = out.decode("utf-8").rstrip()
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    if answer == expected_output:
        print("| Test", test_num, ": SUCCESS.")
        return
    
    test_fail_message = ""
    test_success = True
    
    if answer.count("\n") != expected_output.count("\n"):
        test_fail_message = "The number of generated answer output lines does not match that of the expected output."
        test_success = False
    
    if test_success:
        answer_lines = answer.split("\n")
        expected_output_lines = expected_output.split("\n")

        for lineNumber in range(len(answer_lines)):
            if answer_lines[lineNumber].rstrip() != expected_output_lines[lineNumber].rstrip():
                test_success = False

                test_fail_message += f"""
Your output on line {str(lineNumber+1)} "{answer_lines[lineNumber].rstrip()}" does not match the \
expected output "{expected_output_lines[lineNumber].rstrip()}"\
"""

    if test_success:
        print("| Test", test_num, ": SUCCESS.")
        return

    print("Test", test_num, "FAILED.")
    print("=== YOUR OUTPUT IS BELOW =======")
    print(answer)
    print("=== END OF YOUR OUTPUT =========")
    print("=== EXPECTED OUTPUT IS BELOW ===")
    print(expected_output)
    print("=== END OF EXPECTED OUTPUT =====")
    print(test_fail_message)


if __name__ == "__main__":

    exec_root = Path(sys.argv[1])

    main_path = exec_root / "Main.py"

    backref_fpath = exec_root / "backref.txt"
    if backref_fpath.is_file():
        with open(backref_fpath) as backref_file:
            test_root = Path(backref_file.readline().strip()).parent
    else:
        test_root = exec_root

    tester_name = "Tester"
    tester_path = test_root / "Tester.py"
    spec = importlib.util.spec_from_file_location(tester_name, tester_path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[tester_name] = module
    spec.loader.exec_module(module)

    tests = [(f'Example{n}', i, o) for n, i, o in (f() for n, f in inspect.getmembers(module, inspect.isfunction) if n.startswith('test'))]
    testcases = test_root.parent / 'testcases'
    for iname, oname in zip(testcases.glob("input*"), testcases.glob("output*")):
        with open(iname) as ifile, open(oname) as ofile:
            tests.append((f'Testcase{iname.name[5:]}', ifile.read(), ofile.read()))

    for test in tests:
        runtest(main_path.resolve(), test, test_root.resolve())



