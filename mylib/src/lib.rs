#[no_mangle]
pub unsafe extern "C" fn mylib_test() {
    println!("Do the thing");
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
