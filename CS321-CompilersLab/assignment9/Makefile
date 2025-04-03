# Compiler and flags
CXX = g++
CXXFLAGS = -Wall -g

# Target executable
TARGET = compiler

# Source files
PARSER = Q.y
LEXER = Q.l

# Test files
TEST_FILES = gcd.txt interest.txt triangle.txt
OUTPUT_FILES = gcd_output.txt interest_output.txt triangle_output.txt

all: $(TARGET)

$(TARGET): lex.yy.c y.tab.c block.hpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) y.tab.c -lfl

y.tab.c y.tab.h: $(PARSER)
	bison -d -y $(PARSER)

lex.yy.c: $(LEXER) y.tab.h
	flex $(LEXER)

test: $(TARGET) $(TEST_FILES)
	@echo "Running tests..."
	./$(TARGET) gcd.txt gcd_output.txt
	./$(TARGET) interest.txt interest_output.txt
	./$(TARGET) triangle.txt triangle_output.txt
	@echo "All tests completed. Check output files for results."

clean:
	rm -f $(TARGET) lex.yy.c y.tab.c y.tab.h $(OUTPUT_FILES)

.PHONY: all test clean