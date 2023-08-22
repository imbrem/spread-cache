#[inline(never)]
pub fn next_index(mut current_index: usize, work_factor: usize, value: u8) -> usize {
    for i in 0..work_factor {
        current_index = fxhash::hash(&(current_index, work_factor, i, value));
    }
    current_index
}