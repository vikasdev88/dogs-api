import { useState } from 'react'
import GetFetchRequest from '../../../../services/api/GetFetchRequest';
import { BREED_PATH } from '../constants';

const useGetBreedImage = ({ breed, setBreedImage, breedImage, setLoading }) => {
  const [errors, setErrors] = useState('');

  const getBreedImage = async () => {
    try {
      setLoading(true)
      const urlParams = `dogs[breed]=${breed}`;
      const response = await GetFetchRequest(BREED_PATH, urlParams)
      const jsonResponse = await response.json();
      setBreedImage({ ...breedImage, imageUrl: jsonResponse["result"], errors: jsonResponse["errors"] })
    } catch (e) {
      setErrors(e.message)
    }
    setLoading(false)
  }
  return ({
    getBreedImage,
    errors
  });
}

export default useGetBreedImage
