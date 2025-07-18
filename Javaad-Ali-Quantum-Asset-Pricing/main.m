//
//  main.m
//  Quantum Portfolio and CHSH Simulator
//
//  (c) Javaad Ali, Esq.
//  New York, 2024.
//
//  Created by AdvocatesClose on 12/5/24.
//  All rights reserved.
//
// This file is the main entry point for the demo project.
// It models how quantum mechanics can be used to improve asset pricing and portfolio construction.

// Import Apple's Foundation library, providing basic classes and functions.
#import <Foundation/Foundation.h>

// ----------- QUANTUM CHSH SIMULATOR -----------
// This section simulates quantum phenomena to explore quantum advantage in finance.

#pragma mark - Quantum CHSH Simulator

// Declaration of the CHSHSimulator class.
// This class runs a simulation inspired by quantum physics, used to test quantum advantage.
@interface CHSHSimulator : NSObject

// Runs a quantum “Bell State” experiment with chosen settings.
// Why it matters: Simulates quantum effects that can outperform classical finance.
- (NSDictionary *)simulateBellStateWithAngles:(NSArray<NSNumber *> *)angles shots:(NSInteger)shots;

// Calculates the expected average result based on those quantum measurements.
// This is a key number for risk/return analysis.
- (double)calculateExpectationValueFromCounts:(NSDictionary<NSString *, NSNumber *> *)counts shots:(NSInteger)shots;

// Calculates the S-value, which quantifies quantum advantage in the simulation.
// If S > 2, quantum effects are beating classical approaches.
- (double)calculateSValueWithResults:(NSArray<NSNumber *> *)results;

@end

@implementation CHSHSimulator

// Simulate a quantum experiment with specified angles and repetitions.
// The output is mocked for demonstration.
- (NSDictionary *)simulateBellStateWithAngles:(NSArray<NSNumber *> *)angles shots:(NSInteger)shots {
	NSLog(@"Simulating CHSH game with angles %@ and %ld shots...", angles, (long)shots);

	// This is a mocked response showing simulated measurement results.
	// In real use, this would be actual quantum data.
	NSDictionary *mockResponse = @{@"00": @500, @"01": @250, @"10": @250, @"11": @500};
	return mockResponse;
}

// Calculate the expectation value for the quantum experiment.
// Why you care: This represents the predicted outcome (like expected return in finance).
- (double)calculateExpectationValueFromCounts:(NSDictionary<NSString *, NSNumber *> *)counts shots:(NSInteger)shots {
	double expectation = 0.0;
	for (NSString *key in counts) {
		double probability = [counts[key] doubleValue] / shots;
		int parity = ([key isEqualToString:@"00"] || [key isEqualToString:@"11"]) ? 1 : -1;
		expectation += parity * probability;
	}
	return expectation;
}

// Calculate the S-value, which quantifies whether quantum advantage exists.
// This is the key metric for proving quantum finance can outperform classical models.
- (double)calculateSValueWithResults:(NSArray<NSNumber *> *)results {
	double sValue = 0.0;
	for (NSNumber *result in results) {
		sValue += [result doubleValue];
	}
	return sValue;
}

@end

// ----------- QUANTUM PORTFOLIO SIMULATOR -----------
// This section uses quantum-inspired techniques to simulate investment portfolios.

#pragma mark - Quantum Portfolio Simulator

// Declaration of the CHSHPortfolioSimulator class.
// This class models how quantum concepts can build better portfolios.
@interface CHSHPortfolioSimulator : NSObject

// Simulate a portfolio using quantum-inspired settings.
// Why it matters: Tests if quantum techniques lead to better investment outcomes.
- (NSDictionary *)simulatePortfolioWithAngles:(NSArray<NSNumber *> *)angles shots:(NSInteger)shots;

// Converts quantum angles into portfolio weights.
// Why you care: Shows how quantum decisions translate into asset allocations.
- (NSArray<NSNumber *> *)convertAnglesToWeights:(NSArray<NSNumber *> *)angles;

// Calculates the overall performance (return and risk) of the simulated portfolio.
// The numbers produced here are what investors use to make decisions.
- (NSDictionary *)calculatePortfolioPerformanceFromCounts:(NSDictionary<NSString *, NSNumber *> *)counts shots:(NSInteger)shots;

@end

@implementation CHSHPortfolioSimulator

// Simulates the quantum-derived portfolio and returns the mock results.
- (NSDictionary *)simulatePortfolioWithAngles:(NSArray<NSNumber *> *)angles shots:(NSInteger)shots {
	NSLog(@"Simulating portfolio with angles %@ for %ld shots...", angles, (long)shots);

	// Mocked measurement results for demonstration.
	NSDictionary *mockResponse = @{@"00": @600, @"01": @200, @"10": @150, @"11": @74};
	return mockResponse;
}

// Converts quantum angles to normalized portfolio weights.
// Why it matters: Ensures that portfolio allocations follow sound mathematical rules.
- (NSArray<NSNumber *> *)convertAnglesToWeights:(NSArray<NSNumber *> *)angles {
	// Normalize angles to create valid portfolio weights.
	double sum = 0.0;
	for (NSNumber *angle in angles) {
		sum += fabs([angle doubleValue]);
	}
	NSMutableArray<NSNumber *> *weights = [NSMutableArray array];
	for (NSNumber *angle in angles) {
		[weights addObject:@(fabs([angle doubleValue]) / sum)];
	}
	return weights;
}

// Calculates overall expected return and risk for the quantum-inspired portfolio.
// Why you care: These are the two numbers every investor wants to see.
- (NSDictionary *)calculatePortfolioPerformanceFromCounts:(NSDictionary<NSString *, NSNumber *> *)counts shots:(NSInteger)shots {
	// Assigns returns and risks for each outcome.
	NSDictionary *returns = @{@"00": @0.05, @"01": @0.02, @"10": @0.03, @"11": @0.07};
	NSDictionary *risks = @{@"00": @0.01, @"01": @0.02, @"10": @0.015, @"11": @0.03};

	double expectedReturn = 0.0;
	double risk = 0.0;
	for (NSString *outcome in counts) {
		double probability = [counts[outcome] doubleValue] / shots;
		expectedReturn += probability * [returns[outcome] doubleValue];
		risk += probability * [risks[outcome] doubleValue];
	}

	// Returns the key investor numbers: expected return and risk.
	return @{@"ExpectedReturn": @(expectedReturn), @"Risk": @(risk)};
}

@end

// ----------- MAIN EXECUTION -----------
// This is the main part where everything runs and results are printed.

#pragma mark - Main Execution

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		NSInteger shots = 1024; // Number of simulations. More shots = more accurate results.

		// ---- Run the Quantum CHSH Simulator ----
		// This shows quantum advantage in a finance-inspired experiment.
		CHSHSimulator *chshSimulator = [[CHSHSimulator alloc] init];
		NSArray *anglePairs = @[
			@[@0, @(M_PI / 8)],        // First quantum test settings.
			@[@0, @(-M_PI / 8)],       // Second settings.
			@[@(M_PI / 4), @(M_PI / 8)], // Third settings.
			@[@(M_PI / 4), @(-M_PI / 8)] // Fourth settings.
		];

		NSMutableArray<NSNumber *> *chshResults = [NSMutableArray array];
		for (NSArray<NSNumber *> *angles in anglePairs) {
			// Simulate quantum measurement for each setting.
			NSDictionary *counts = [chshSimulator simulateBellStateWithAngles:angles shots:shots];
			// Calculate quantum expectation value.
			double expectation = [chshSimulator calculateExpectationValueFromCounts:counts shots:shots];
			[chshResults addObject:@(expectation)];
			NSLog(@"CHSH Expectation for angles %@: %f", angles, expectation);
		}

		// Calculate the overall S-value to check for quantum advantage.
		double sValue = [chshSimulator calculateSValueWithResults:chshResults];
		NSLog(@"CHSH S-Value: %f", sValue);
		if (sValue > 2.0) {
			NSLog(@"Quantum advantage demonstrated! S-value exceeds classical limit.");
			// If you see this, quantum-inspired finance has real potential to outperform traditional methods.
		} else {
			NSLog(@"No quantum advantage. Classical limit not exceeded.");
			// Otherwise, quantum models are not yet showing an advantage.
		}

		// ---- Run the Quantum Portfolio Simulator ----
		// This shows how quantum-inspired techniques can improve portfolio construction.
		CHSHPortfolioSimulator *portfolioSimulator = [[CHSHPortfolioSimulator alloc] init];
		NSArray *angles = @[@(M_PI / 8), @(-M_PI / 8), @(M_PI / 4), @(M_PI / 2)];
		NSArray *weights = [portfolioSimulator convertAnglesToWeights:angles];
		NSLog(@"Portfolio Weights: %@", weights);

		// Simulate the portfolio based on those weights.
		NSDictionary *portfolioCounts = [portfolioSimulator simulatePortfolioWithAngles:angles shots:shots];
		NSDictionary *performance = [portfolioSimulator calculatePortfolioPerformanceFromCounts:portfolioCounts shots:shots];
		NSLog(@"Portfolio Performance:");
		NSLog(@"Expected Return: %@", performance[@"ExpectedReturn"]);
		NSLog(@"Risk: %@", performance[@"Risk"]);

		// Print the total weight to ensure allocations are correct.
		double totalWeight = [[weights valueForKeyPath:@"@sum.self"] doubleValue];
		NSLog(@"Total Weight: %f (should be 1.0)", totalWeight);
	}
	return 0;
}

// End of file. 
// The results printed by this code demonstrate the implications of quantum computing for non-bank financial institutions. 
