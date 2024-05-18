import React from 'react'
import Alert from '../../Alert'
import NoImage from './NoImage'
import Image from './Image'
import Loader from '../Loader'
import { isEmpty } from 'lodash'

const ImageContainer = ({ imageResponse, loading }) => {
  return (
    <div className="container-fluid">
      <div className="row justify-content-center">
        <div className="col-12">
          <div className='m-2 card'>
            <div className='card-body shadow p-4'>
              <div className="mb-3 d-flex justify-content-center align-items-center">
                {
                  loading ? <Loader /> :
                    imageResponse.errors !== null && !isEmpty(imageResponse.errors) ? <Alert message={imageResponse.errors} /> :
                      imageResponse.imageUrl === null || isEmpty(imageResponse.imageUrl) ? <NoImage /> :
                        <Image imageUrl={imageResponse.imageUrl} />
                }
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ImageContainer
