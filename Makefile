# Makefile
# Simplified pipeline for word count and plotting
# Author: Zhiwei Zhang
# Date: 2024/12/16

# Example usage:
# make all

all : report/count_report.html

# Generate word count results
results/isles.dat : data/isles.txt scripts/wordcount.py
	python scripts/wordcount.py \
		--input_file=data/isles.txt \
		--output_file=results/isles.dat

results/abyss.dat : data/abyss.txt scripts/wordcount.py
	python scripts/wordcount.py \
		--input_file=data/abyss.txt \
		--output_file=results/abyss.dat

results/last.dat : data/last.txt scripts/wordcount.py
	python scripts/wordcount.py \
		--input_file=data/last.txt \
		--output_file=results/last.dat

# Plots
results/figure/isles.png : results/isles.dat scripts/plotcount.py
	python scripts/plotcount.py \
		--input_file=results/isles.dat \
		--output_file=results/figure/isles.png

results/figure/abyss.png : results/abyss.dat scripts/plotcount.py
	python scripts/plotcount.py \
		--input_file=results/abyss.dat \
		--output_file=results/figure/abyss.png

results/figure/last.png : results/last.dat scripts/plotcount.py
	python scripts/plotcount.py \
		--input_file=results/last.dat \
		--output_file=results/figure/last.png

# Render report
report/count_report.html : report/count_report.qmd \
results/figure/isles.png \
results/figure/abyss.png \
results/figure/last.png
	quarto render report/count_report.qmd --to html

# Clean up
clean :
	rm -f results/isles.dat \
	      results/abyss.dat \
	      results/last.dat
	rm -f results/figure/isles.png \
	      results/figure/abyss.png \
	      results/figure/last.png
	rm -f report/count_report.html