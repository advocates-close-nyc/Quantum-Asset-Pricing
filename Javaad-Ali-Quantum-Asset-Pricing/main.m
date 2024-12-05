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

#import <Foundation/Foundation.h>

#pragma mark - Quantum CHSH Simulator

@interface CHSHSimulator : NSObject

- (NSDictionary *)simulateBellStateWithAngles:(NSArray<NSNumber *> *)angles shots:(NSInteger)shots;
- (double)calculateExpectationValueFromCounts:(NSDictionary<NSString *, NSNumber *> *)counts shots:(NSInteger)shots;
- (double)calculateSValueWithResults:(NSArray<NSNumber *> *)results;

@end

@implementation CHSHSimulator

- (NSDictionary *)simulateBellStateWithAngles:(NSArray<NSNumber *> *)angles shots:(NSInteger)shots {
	NSLog(@"Simulating CHSH game with angles %@ and %ld shots...", angles, (long)shots);

		// Mocked response (measurement counts)
	NSDictionary *mockResponse = @{@"00": @500, @"01": @250, @"10": @250, @"11": @500};
	return mockResponse;
}

- (double)calculateExpectationValueFromCounts:(NSDictionary<NSString *, NSNumber *> *)counts shots:(NSInteger)shots {
	double expectation = 0.0;
	for (NSString *key in counts) {
		double probability = [counts[key] doubleValue] / shots;
		int parity = ([key isEqualToString:@"00"] || [key isEqualToString:@"11"]) ? 1 : -1;
		expectation += parity * probability;
	}
	return expectation;
}

- (double)calculateSValueWithResults:(NSArray<NSNumber *> *)results {
	double sValue = 0.0;
	for (NSNumber *result in results) {
		sValue += [result doubleValue];
	}
	return sValue;
}

@end

#pragma mark - Quantum Portfolio Simulator

@interface CHSHPortfolioSimulator : NSObject

- (NSDictionary *)simulatePortfolioWithAngles:(NSArray<NSNumber *> *)angles shots:(NSInteger)shots;
- (NSArray<NSNumber *> *)convertAnglesToWeights:(NSArray<NSNumber *> *)angles;
- (NSDictionary *)calculatePortfolioPerformanceFromCounts:(NSDictionary<NSString *, NSNumber *> *)counts shots:(NSInteger)shots;

@end

@implementation CHSHPortfolioSimulator

- (NSDictionary *)simulatePortfolioWithAngles:(NSArray<NSNumber *> *)angles shots:(NSInteger)shots {
	NSLog(@"Simulating portfolio with angles %@ for %ld shots...", angles, (long)shots);

		// Mocked response (measurement counts)
	NSDictionary *mockResponse = @{@"00": @600, @"01": @200, @"10": @150, @"11": @74};
	return mockResponse;
}

- (NSArray<NSNumber *> *)convertAnglesToWeights:(NSArray<NSNumber *> *)angles {
		// Normalize angles to portfolio weights
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

- (NSDictionary *)calculatePortfolioPerformanceFromCounts:(NSDictionary<NSString *, NSNumber *> *)counts shots:(NSInteger)shots {
	NSDictionary *returns = @{@"00": @0.05, @"01": @0.02, @"10": @0.03, @"11": @0.07};
	NSDictionary *risks = @{@"00": @0.01, @"01": @0.02, @"10": @0.015, @"11": @0.03};

	double expectedReturn = 0.0;
	double risk = 0.0;
	for (NSString *outcome in counts) {
		double probability = [counts[outcome] doubleValue] / shots;
		expectedReturn += probability * [returns[outcome] doubleValue];
		risk += probability * [risks[outcome] doubleValue];
	}

	return @{@"ExpectedReturn": @(expectedReturn), @"Risk": @(risk)};
}

@end

#pragma mark - Main Execution

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		NSInteger shots = 1024;

			// CHSH Simulator
		CHSHSimulator *chshSimulator = [[CHSHSimulator alloc] init];
		NSArray *anglePairs = @[
			@[@0, @(M_PI / 8)],        // E(a, b)
			@[@0, @(-M_PI / 8)],       // E(a, b')
			@[@(M_PI / 4), @(M_PI / 8)], // E(a', b)
			@[@(M_PI / 4), @(-M_PI / 8)] // E(a', b')
		];

		NSMutableArray<NSNumber *> *chshResults = [NSMutableArray array];
		for (NSArray<NSNumber *> *angles in anglePairs) {
			NSDictionary *counts = [chshSimulator simulateBellStateWithAngles:angles shots:shots];
			double expectation = [chshSimulator calculateExpectationValueFromCounts:counts shots:shots];
			[chshResults addObject:@(expectation)];
			NSLog(@"CHSH Expectation for angles %@: %f", angles, expectation);
		}

		double sValue = [chshSimulator calculateSValueWithResults:chshResults];
		NSLog(@"CHSH S-Value: %f", sValue);
		if (sValue > 2.0) {
			NSLog(@"Quantum advantage demonstrated! S-value exceeds classical limit.");
		} else {
			NSLog(@"No quantum advantage. Classical limit not exceeded.");
		}

			// Portfolio Simulator
		CHSHPortfolioSimulator *portfolioSimulator = [[CHSHPortfolioSimulator alloc] init];
		NSArray *angles = @[@(M_PI / 8), @(-M_PI / 8), @(M_PI / 4), @(M_PI / 2)];
		NSArray *weights = [portfolioSimulator convertAnglesToWeights:angles];
		NSLog(@"Portfolio Weights: %@", weights);

		NSDictionary *portfolioCounts = [portfolioSimulator simulatePortfolioWithAngles:angles shots:shots];
		NSDictionary *performance = [portfolioSimulator calculatePortfolioPerformanceFromCounts:portfolioCounts shots:shots];
		NSLog(@"Portfolio Performance:");
		NSLog(@"Expected Return: %@", performance[@"ExpectedReturn"]);
		NSLog(@"Risk: %@", performance[@"Risk"]);

		double totalWeight = [[weights valueForKeyPath:@"@sum.self"] doubleValue];
		NSLog(@"Total Weight: %f (should be 1.0)", totalWeight);
	}
	return 0;
}
