use criterion::black_box;
use criterion::BenchmarkId;
use criterion::Criterion;
use criterion::Throughput;
use criterion::{criterion_group, criterion_main};

use spread_cache::next_index;

fn spread_cache(c: &mut Criterion) {
    const LOG_MAX_SPREAD: u32 = 30;
    const MAX_SPREAD: usize = 1 << LOG_MAX_SPREAD;
    let mut buffer = vec![123u8; MAX_SPREAD];
    let mut current_index = 0;

    let mut group: criterion::BenchmarkGroup<'_, criterion::measurement::WallTime> =
        c.benchmark_group("spread_cache");

    for log_spread in 8..=LOG_MAX_SPREAD {
        group.throughput(Throughput::Elements(1));
        group.bench_with_input(
            BenchmarkId::new("repeat", log_spread),
            &(log_spread - 8),
            |b, &log_index| {
                b.iter(|| {
                    let next_index =
                        next_index(current_index % (1 << log_index), 1, buffer[current_index])
                            % MAX_SPREAD;
                    buffer[current_index] = next_index as u8;
                    current_index = next_index
                });
            },
        );
    }

    for log_spread in 8..=LOG_MAX_SPREAD {
        group.throughput(Throughput::Elements(32));
        group.bench_with_input(
            BenchmarkId::new("repeat_32", log_spread),
            &(log_spread - 8),
            |b, &log_index| {
                b.iter(|| {
                    let next_index =
                        next_index(current_index % (1 << log_index), 32, buffer[current_index])
                            % MAX_SPREAD;
                    buffer[current_index] = next_index as u8;
                    current_index = next_index
                });
            },
        );
    }

    for log_spread in 0..=LOG_MAX_SPREAD {
        group.throughput(Throughput::Elements(1));
        group.bench_with_input(
            BenchmarkId::new("linear", log_spread),
            &log_spread,
            |b, &log_spread| {
                b.iter(|| {
                    let next_index =
                        next_index(current_index, 1, buffer[current_index]) % (1 << log_spread);
                    buffer[current_index] = next_index as u8;
                    current_index += 1;
                    current_index %= 1 << log_spread;
                });
            },
        );
    }

    group.throughput(Throughput::Elements(1));
    group.bench_with_input("work_1", &LOG_MAX_SPREAD, |b, &log_spread| {
        b.iter(|| {
            let next_index =
                next_index(current_index, 1, buffer[current_index]) % (1 << log_spread);
            black_box(next_index)
        });
    });

    group.throughput(Throughput::Elements(32));
    group.bench_with_input("work_32", &LOG_MAX_SPREAD, |b, &log_spread| {
        b.iter(|| {
            let next_index =
                next_index(current_index, 32, buffer[current_index]) % (1 << log_spread);
            black_box(next_index)
        });
    });

    for log_spread in 0..=LOG_MAX_SPREAD {
        group.throughput(Throughput::Elements(1));
        group.bench_with_input(
            BenchmarkId::new("spread", log_spread),
            &log_spread,
            |b, &log_spread| {
                b.iter(|| {
                    let next_index =
                        next_index(current_index, 1, buffer[current_index]) % (1 << log_spread);
                    buffer[current_index] = next_index as u8;
                    current_index = next_index
                });
            },
        );
    }

    for log_spread in 0..=LOG_MAX_SPREAD {
        group.throughput(Throughput::Elements(32));
        group.bench_with_input(
            BenchmarkId::new("spread_32", log_spread),
            &log_spread,
            |b, &log_spread| {
                b.iter(|| {
                    let next_index =
                        next_index(current_index, 32, buffer[current_index]) % (1 << log_spread);
                    buffer[current_index] = next_index as u8;
                    current_index = next_index
                });
            },
        );
    }
}

criterion_group!(benches, spread_cache);
criterion_main!(benches);
