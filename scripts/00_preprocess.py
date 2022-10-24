#!/usr/bin/env python3
from pathlib import Path
import typer
from wasabi import msg

"""
This file preprocesses a file of text to the required input format for scripts/01_parse.py
"""

def main(
    in_file: str = typer.Argument(..., help="Path to input file"), 
    out_dir: str = typer.Argument(..., help="Path to output directory")
    ):
    """
    Preprocess a file
    Example usage: `python preprocess.py data.txt output_directory/`
    """
    input_path = Path(in_file)
    output_path = Path(out_dir)
    if not input_path.exists():
        msg.fail("Can't find input file", in_file, exits=1)
    if not output_path.exists():
        output_path.mkdir(parents=True)
        msg.good(f"Created output directory {out_dir}")

    # strip the filename from filepath 
    filename = input_path.stem
    # create a new file with the same name as the input file with preprocessed_ prefix 
    output_path = output_path / f"preprocessed_{filename}.txt"
    # open the input file
    with input_path.open("r", encoding="utf8") as input_text, \
        output_path.open("w", encoding="utf8") as output_file:
        # remove all newline characters from the input file
        text = input_text.read().replace("\n", "")
        # write the preprocessed text to the output file
        for line in text.split(". "):
            # write each sentence to the output file
            output_file.write(line + "\n")

if __name__ == "__main__":
    typer.run(main)