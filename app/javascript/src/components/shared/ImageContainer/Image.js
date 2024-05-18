import React from 'react';

const Image = ({ imageUrl }) => {
  return (
    <img className='img-fluid p-1' style={{ width: '300px', height: '300px' }} src={imageUrl} alt="Breed Image" />
  );
}

export default Image;
