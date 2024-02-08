import React from "react";
import { Card, Col } from "react-bootstrap";
import { useNavigate } from "react-router-dom";
import { PropTypes } from "prop-types";
import debug from "sabio-debug";

const _logger = debug.extend("blog");

function BlogCard(props) {
  const { aNewBlog } = props;
  _logger("blog map", aNewBlog);

  const navigate = useNavigate();
  const handleOnClick = () => {
    navigate(`/article/${aNewBlog.id}`);
  };

  let date = new Date(aNewBlog?.dateCreated);
  let options = {
    year: "numeric",
    month: "long",
    day: "numeric",
  };
  let formattedDate = date.toLocaleDateString("en-US", options);

  return (
    <Card className="bg-dark text-white mb-4 blog-card-col" key={aNewBlog?.id}>
      <Card.Img
        src={aNewBlog?.imageUrl}
        alt="aNewBlogCard image"
        onClick={handleOnClick}
        className="rounded-top-md w-100 blogcard-image"
      />
      <Card.ImgOverlay>
        <Card.Title
          className="blogcard-title text-primary fw-bold"
          onClick={handleOnClick}
        >
          {aNewBlog?.title}
        </Card.Title>
        <Card.Text className="blogcard-category">
          {aNewBlog?.category.name}
        </Card.Text>
        <Card.Text className="mb-4 blogcard-body text-white">
          {aNewBlog?.content.slice(0, 150)} . . .
        </Card.Text>
        <Card.Text className="blogcard-author text-white">
          <Col className="col 1h-1">
            <h3 className="mb-1">
              {aNewBlog?.author.firstName}&nbsp;{aNewBlog?.author.lastName}
            </h3>
            <p className="blogcard-publishdate text-white">{formattedDate}</p>
          </Col>
        </Card.Text>
      </Card.ImgOverlay>
    </Card>
  );
}

BlogCard.propTypes = {
  aNewBlog: PropTypes.shape({
    id: PropTypes.number,
    imageUrl: PropTypes.string,
    category: PropTypes.string,
    title: PropTypes.string.isRequired,
    subject: PropTypes.string.isRequired,
    content: PropTypes.string,
    author: PropTypes.string,
    dateCreated: PropTypes.instanceOf(Date),
  }),
};

export default BlogCard;
