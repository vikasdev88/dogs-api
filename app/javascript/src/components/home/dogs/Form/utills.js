export const handleOnBreedChange = (e, setBreed) => {
  setBreed(e.target.value);
}

export const initialBreedImageStat = { errors: null, imageUrl: null }

export const handleResetBreed = (setBreed, setImage) => {
  setBreed('');
  setImage(initialBreedImageStat)
}
