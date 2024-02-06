import React, { useEffect, useState } from "react";
import { Card, Col, FormSelect, Pagination, Row, Table } from "react-bootstrap";
import debug from "sabio-debug";
import blogService from "services/blogService";
import lookUpService from "services/lookUpService";
import * as helper from "../../helper/utils";
import "./blogs.css";
import BlogCard from "./BlogCard";

const _logger = debug.extend("blog");

function BlogListing() {
  const [blogData, setBlogData] = useState({
    arrayOfBlogs: [],
    blogComponents: [],
    totalResults: [],
    pageIndex: 1,
    pageSize: 3,
    selectedCategory: 0,
    selectAuthor: 1,
    currentPage: 1,
  });

  const [lookUpData, setLookUpType] = useState({
    blogTypes: [],
    mappedBlogTypes: [],
  });

  useEffect(() => {
    lookUpService.lookUp(["BlogTypes"]).then(onLookSuccess).catch(onLookError);
    if (blogData.selectedCategory > 0) {
      blogService
        .GetByCategory(
          blogData.selectedCategory,
          blogData.pageIndex - 1,
          blogData.pageSize
        )
        .then(renderBlogSuccess)
        .catch(renderBlogError);
    } else {
      blogService
        .paginateBlogListing(blogData.pageIndex - 1, blogData.pageSize)
        .then(renderBlogSuccess)
        .catch(renderBlogError);
    }
  }, [blogData.pageIndex, blogData.selectedCategory]);

  const onLookSuccess = (response) => {
    _logger("onLookSuccess", response);
    const { blogTypes } = response.item;

    setLookUpType((prevState) => {
      let newBlog = { ...prevState, blogTypes };
      newBlog.mappedBlogTypes = newBlog.blogTypes.map(helper.mapLookUpItem);
      return newBlog;
    });
    _logger(lookUpData);
  };

  const onLookError = (error) => {
    _logger("onLookError", error);
  };

  const onCurrentPage = (page) => {
    setBlogData((prevState) => {
      let newState = { ...prevState };
      newState.currentPage = page;
      newState.pageIndex = page;
      return newState;
    });
  };

  const renderBlogSuccess = (response) => {
    _logger("renderBlogSuccess", response);
    let { pagedItems, totalCount } = response.item;

    setBlogData((prevState) => {
      let newBlogObj = { ...prevState };
      newBlogObj.arrayOfBlogs = pagedItems;
      newBlogObj.blogComponents = pagedItems.map(cardMap);
      newBlogObj.totalResults = totalCount;
      return newBlogObj;
    });
  };

  const renderBlogError = (error) => {
    _logger("renderBlogError", error, lookUpData, mainBlog);
  };

  const cardMap = (aNewBlog) => {
    return (
      <div className="col space-around space-between" key={aNewBlog.Id}>
        <div>
          <h1>{aNewBlog.blogTypes}</h1>
        </div>
        <BlogCard aNewBlog={aNewBlog} />
      </div>
    );
  };

  const filterByCategory = (e) => {
    e.preventDefault();
    let { value } = e.target;
    setBlogData((prevState) => {
      let newState = { ...prevState };
      newState.pageIndex = 1;
      newState.selectedCategory = value;
      return newState;
    });
  };
  const mainBlog =
    blogData.arrayOfBlogs.length > 0 ? blogData.arrayOfBlogs[0] : null;

  return (
    <React.Fragment>
      <div className="BlogListing">
        <div>
          <Row className="mx-auto">
            <header className="BlogListing-header text-center py-5">
              <Card>
                <Card.Img
                  src="https://i.imgur.com/mzvY7Ny.jpg"
                  title="blogheader"
                  className="blogheader w-100 image-fluid"
                  alt="blogheaderimage"
                />
                <Card.ImgOverlay>
                  <div className="bloglist-img-overlay">
                    <h1 className="text-white center py-auto mx-auto display-4 fw-bold bloglist-title ">
                      Guidance for Reaching Your Financial Goals
                    </h1>
                  </div>
                </Card.ImgOverlay>
              </Card>
            </header>
          </Row>
        </div>

        <Row className="mb-3 me-5 ms-5 ">
          <Col
            className="justify-content-between align-items-center"
            md={7}
            lg={7}
            xl={7}
          >
            {blogData.blogComponents}
          </Col>
          <Col md={4} lg={4} xl={4} className="column-select align-top">
            <Table>
              <tr className="align-top">
                {" "}
                <Row>
                  <Col>
                    {" "}
                    <div className="bloglist-upperselect-text">
                      <p>
                        Not seeing the information you were hoping to find? Use
                        the dropdown menu below and select the category of what
                        you are looking for to see more
                      </p>
                    </div>
                  </Col>
                </Row>
              </tr>

              <tr>
                {" "}
                <Row>
                  <Col>
                    <FormSelect
                      as="select"
                      placeholder="Sort by"
                      className="bloglist-catdrop form-control me-3"
                      onChange={filterByCategory}
                    >
                      <option>Select By Topic</option>
                      {lookUpData.mappedBlogTypes}
                    </FormSelect>
                  </Col>
                </Row>
              </tr>
            </Table>
          </Col>
        </Row>
      </div>
      <hr></hr>
      <div className="pb-8 py-6">
        <Row className="mx-auto me-5 blog-w ms-5">
          <div className="d-flex justify-content-center">
            <Pagination
              className="blog-pagination-item blog-pagination-item-active"
              onChange={onCurrentPage}
              current={blogData.pageIndex}
              total={blogData.totalResults}
            ></Pagination>
          </div>
        </Row>
      </div>
    </React.Fragment>
  );
}

export default BlogListing;
