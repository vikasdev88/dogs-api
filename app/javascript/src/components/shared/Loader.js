import React from 'react';

const Loader = () => {
  return (
    <div className="col-12 mx-auto d-flex justify-content-center align-items-center">
      <div>
        <span className="p-2 mx-2 spinner-border spinner-border-lg" role="status" aria-hidden="true"></span>
      </div>
    </div>
  );
}

export default Loader;
