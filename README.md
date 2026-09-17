# Huffman Text Compression

A MATLAB-based implementation of **Huffman Coding for lossless text compression**.

## Project Overview

This project demonstrates text compression using the **Huffman Coding algorithm**. The system provides an interactive transmitter and receiver interface where the user can enter text, generate Huffman codes, compress the text into a binary stream, and decompress it back to the original text.

The project also calculates important information-theoretic parameters such as:

- Shannon Entropy
- Average Code Length
- Coding Efficiency
- Space Saved

## Features

- Interactive MATLAB GUI
- Transmitter and Receiver sections
- Original text input
- Character frequency calculation
- Character probability calculation
- Huffman tree construction
- Huffman code generation
- Compressed binary stream generation
- Lossless text decompression
- Decompressed text verification
- Shannon Entropy calculation
- Average Code Length calculation
- Coding Efficiency calculation
- Space Saved calculation

## How the System Works

### Transmitter

The transmitter accepts the original text and performs the following steps:

1. Accepts the input text.
2. Calculates the frequency of each character.
3. Calculates the probability of each character.
4. Constructs the Huffman tree.
5. Generates Huffman codes.
6. Converts the original text into a compressed binary stream.
7. Displays the compression information and coding parameters.

### Receiver

The receiver performs the following steps:

1. Receives the compressed binary stream.
2. Uses the generated Huffman codes to decode the binary data.
3. Reconstructs the original text.
4. Displays the decompressed text.
5. Compares the decompressed text with the original text.
6. Displays the verification status.

## Huffman Coding Algorithm

Huffman Coding is a **lossless data compression technique** that assigns shorter binary codes to frequently occurring characters and longer binary codes to less frequently occurring characters.

The algorithm generates a **prefix code**, meaning that no Huffman code is the prefix of another Huffman code.

### Frequency and Probability

For each character, its probability is calculated as:

```text
P(xᵢ) = f(xᵢ) / N
```

where:

- `f(xᵢ)` = frequency of character `xᵢ`
- `N` = total number of characters

### Huffman Tree Construction

The algorithm repeatedly selects the two nodes with the lowest frequencies and combines them into a new node.

This process continues until only one root node remains.

The tree is then traversed to generate the Huffman codes:

- Left branch = `0`
- Right branch = `1`

## Mathematical Analysis

### Shannon Entropy

Shannon Entropy represents the theoretical average information content per character.

It is calculated as:

```text
H(X) = -Σ P(xᵢ) log₂ P(xᵢ)
```

### Average Code Length

The average Huffman code length is calculated as:

```text
L = Σ P(xᵢ) l(xᵢ)
```

where:

- `P(xᵢ)` = probability of character `xᵢ`
- `l(xᵢ)` = length of the Huffman code assigned to character `xᵢ`

### Coding Efficiency

The coding efficiency is calculated as:

```text
η = (H(X) / L) × 100%
```

### Space Saved

The percentage of space saved compared with standard 8-bit ASCII representation is calculated as:

```text
Space Saved = (1 - Compressed Bits / Original Bits) × 100%
```

## Example Results

For the input text:

```text
hello world
```

the following results were obtained:

| Parameter | Value |
|---|---:|
| Total Characters | 11 |
| Unique Symbols | 8 |
| Standard ASCII Payload | 88 bits |
| Huffman Compressed Payload | 32 bits |
| Shannon Entropy | 2.8454 bits/character |
| Average Code Length | 2.9091 bits/character |
| Coding Efficiency | 97.81% |
| Space Saved | 63.64% |

The results demonstrate that Huffman Coding can significantly reduce the number of bits required to represent the input text while maintaining lossless reconstruction.

## Huffman Code Example

For the input text `hello world`, an example Huffman code table is:

| Character | Probability | Huffman Code | Code Length |
|---|---:|---:|---:|
| l | 0.273 | 10 | 2 |
| o | 0.182 | 110 | 3 |
| Space | 0.091 | 000 | 3 |
| w | 0.091 | 001 | 3 |
| e | 0.091 | 010 | 3 |
| h | 0.091 | 011 | 3 |
| d | 0.091 | 1110 | 4 |
| r | 0.091 | 1111 | 4 |

## Software Requirements

The project requires:

- MATLAB
- MATLAB GUI components supporting:
  - `uifigure`
  - `uipanel`
  - `uilabel`
  - `uitextarea`
  - `uitable`
  - `uibutton`
  - `containers.Map`

## How to Run

### Step 1: Install MATLAB

Install MATLAB on your computer.

### Step 2: Download the Project

Download or clone this GitHub repository.

### Step 3: Open the Project in MATLAB

Open MATLAB and navigate to the folder containing:

```text
huffman_transmitter_receiver.m
```

### Step 4: Run the Program

Enter the following command in the MATLAB Command Window:

```matlab
huffman_transmitter_receiver
```

### Step 5: Enter Text

Enter your desired text in the **Original Text** box.

### Step 6: Compress the Text

Click the **COMPRESS** button.

The program will:

- Calculate character frequencies
- Calculate probabilities
- Generate Huffman codes
- Generate the compressed binary stream
- Calculate entropy
- Calculate average code length
- Calculate coding efficiency
- Calculate space saved

### Step 7: Decompress the Text

Click the **DECOMPRESS** button.

The program will reconstruct the original text from the compressed binary stream.

### Step 8: Verify the Result

The decompressed text should match the original input text, demonstrating lossless compression.

## Project Structure

```text
HUFFMAN-CODING-FOR-TEXT-COMPRESSION/
│
├── huffman_transmitter_receiver.m
└── README.md
```

## Main File

### `huffman_transmitter_receiver.m`

This MATLAB file contains the complete implementation of the project, including:

- GUI creation
- Original text input
- Character frequency analysis
- Probability calculation
- Huffman tree construction
- Huffman code generation
- Text compression
- Binary stream generation
- Text decompression
- Decoding verification
- Entropy calculation
- Average code length calculation
- Coding efficiency calculation
- Space saved calculation

## Applications

Huffman Coding is useful for demonstrating concepts related to:

- Digital Communication
- Information Theory
- Source Coding
- Data Compression
- Variable-Length Coding
- Prefix Codes
- Binary Trees
- Lossless Compression

## Limitations

The current implementation has the following limitations:

- It uses static Huffman coding.
- The complete input message is analyzed before generating the Huffman codes.
- Codebook transmission overhead is not included in the compression calculation.
- Physical communication channels are not included.
- Channel noise is not modeled.
- Error correction is not implemented.

## Future Scope

The project can be extended by implementing:

- Adaptive Huffman Coding
- Shannon-Fano Coding comparison
- Arithmetic Coding comparison
- Hamming Code
- Reed-Solomon Code
- Noisy communication channel simulation
- Error detection and correction
- Integration with physical or simulated communication systems

## Conclusion

The MATLAB Huffman Text Compression project demonstrates an end-to-end **lossless text compression system**.

The implementation generates Huffman codes based on character frequencies, converts the input text into a variable-length binary stream, and reconstructs the original message during decompression.

For the example input `hello world`, the compressed payload is reduced from **88 bits to 32 bits**, resulting in **63.64% space savings** and **97.81% coding efficiency**.

## References

1. D. A. Huffman, "A Method for the Construction of Minimum-Redundancy Codes," *Proceedings of the IRE*, vol. 40, no. 9, pp. 1098–1101, 1952.

2. C. E. Shannon, "A Mathematical Theory of Communication," *Bell System Technical Journal*, vol. 27, pp. 379–423, 623–656, 1948.

3. T. M. Cover and J. A. Thomas, *Elements of Information Theory*, 2nd ed., Wiley-Interscience, 2006.

4. R. M. Fano, *Transmission of Information: A Statistical Theory of Communications*, MIT Press, Cambridge, Mass., 1961.

5. D. Salomon, *Data Compression: The Complete Reference*, 4th ed., Springer, 2007.

## Authors

**Bhoomi Patil**  
**Komal Naik**

Department of Electronics and Telecommunication Engineering

Pillai College of Engineering

Academic Year: **2025–2026**
