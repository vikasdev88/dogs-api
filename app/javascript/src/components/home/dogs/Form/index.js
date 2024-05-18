import React, { useState } from 'react'
import useGetBreedImage from '../hooks/useGetBreedImage'
import { handleOnBreedChange, handleResetBreed } from './utills';
import { isEmpty } from 'lodash';
import Alert from '../../../Alert';

const Form = ({ breedImage, setBreedImage, loading, setLoading }) => {
  const [breed, setBreed] = useState('');
  const { errors, getBreedImage } = useGetBreedImage({ setLoading, breed, setBreedImage, breedImage });

  if(errors) return < Alert message={errors} type='danger'/>

  return (
    <div className='col-4 bg-secondary p-4 rounded shadow-lg'>
      <div className="mb-3">
        <label className="form-label text-white fw-bold">Please Enter the Breed</label>
        <input onChange={(e) => handleOnBreedChange(e, setBreed)} value={breed} className="form-control" placeholder="Please Enter the Breed" />
      </div>

      <div className="d-grid gap-2">
        <button type="submit" onClick={getBreedImage} className="btn btn-success btn-block" disabled={isEmpty(breed) === true}> {loading ? (
          <>
            Searching...
            <span className="p-1 mx-2 spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
          </>
        ) : (
          "Search"
        )}</button>
        <button type="reset" onClick={() => {
          handleResetBreed(setBreed, setBreedImage)
        }} className="btn bg-white btn-block">Reset</button>
      </div>
    </div>
  )
}

export default Form
