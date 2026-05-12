# Connect Four - The Odin Project

This is a command-line implementation of the classic game Connect Four, developed as part of The Odin Project's Ruby curriculum. The project focuses on test-driven development (TDD), object-oriented design, and complex win-condition algorithms.

## Features

### Game Logic
- **Grid System**: A standard 7x6 board where players drop tokens into columns.
- **Win Condition Detection**: Robust algorithms to detect four-in-a-row horizontally, vertically, and diagonally (both ascending and descending).
- **Draw Detection**: Correctly identifies when the board is full and no more moves can be made.
- **Input Validation**: Ensures players choose valid columns (1-7) and prevents moves in columns that are already full.
- **Player Switching**: Automatically alternates turns between Player 1 (○) and Player 2 (●).

### Quality Assurance
- **Strict TDD**: Built from the ground up using RSpec to ensure logic correctness and reliability.
- **Mocks and Doubles**: Extensive use of test doubles to isolate unit tests for the Board, Match, and Player classes, ensuring high test coverage.
- **Static Analysis**: Adheres to the Ruby Style Guide through rigorous RuboCop linting and configuration.

### User Interface
- **Visual Board**: A clear command-line representation of the grid that updates dynamically after every move.
- **Interactive Prompts**: User-friendly messaging for turn-taking, move requests, and game results.

## Tools and Technologies

- **Ruby**: The core programming language used for logic and structure.
- **RSpec**: The testing framework used to drive the development process through TDD.
- **RuboCop**: Utilized as a linter and static code analyzer to ensure the code adheres to professional standards.

## Installation and Usage

1. Ensure you have Ruby installed on your system.
2. Clone this repository to your local machine.
3. Install the required dependencies using Bundler:
   ```bash
   bundle install
   ```
4. Run the game from the root directory:
   ```bash
   ruby main.rb
   ```
5. To run the test suite:
   ```bash
   rspec
   ```

## Project Structure

- `main.rb`: The entry point of the application.
- `lib/match.rb`: Manages the game flow, including the main loop and player turns.
- `lib/board.rb`: Handles the grid state, piece placement, and win/draw validation logic.
- `lib/player.rb`: A simple class to store player information like names and symbols.
- `spec/`: Contains the complete test suite with unit tests for all classes.
