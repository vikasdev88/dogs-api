import React, { useState } from 'react'
import Form from './Form'
import ImageContainer from '../../shared/ImageContainer'
import { initialBreedImageStat } from './Form/utills'

const DogsContainer = () => {
  const [breedImage, setBreedImage] = useState(initialBreedImageStat)
  const [loading, setLoading] = useState(false);

  return (
    < div className='d-flex justify-content-center align-items-center shadow p-1'>
      < Form
        breedImage={breedImage}
        setBreedImage={setBreedImage}
        loading={loading}
        setLoading={setLoading}
      />
      < ImageContainer imageResponse={breedImage} loading={loading} />
    </div>
  )
}

export default DogsContainer
