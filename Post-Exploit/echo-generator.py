# echo_generator.py

import argparse

def generate_echo_commands(input_file, output_file=None):
    try:
        with open(input_file, 'r') as file:
            content = '; '.join([line.strip() for line in file if line.strip()])
        
        if output_file:
            print(f"echo '{content}' > {output_file}")
        else:
            print(f"echo '{content}'")
    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found.")
        return

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Convert instructions to a single echo command.')
    parser.add_argument('input_file', help='Path to the file containing instructions.')
    parser.add_argument('-o', '--output', help='Optional output file to save the echoed content.', default=None)
    args = parser.parse_args()

    generate_echo_commands(args.input_file, args.output)
