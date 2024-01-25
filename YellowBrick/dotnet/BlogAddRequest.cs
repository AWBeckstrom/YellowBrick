using Sabio.Models.Requests;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Requests.Blogs
{
    public class BlogAddRequest
    {
        [Display(Name = "Blog Category Id")]
        [Required]
        [Range(1, int.MaxValue)]
        public int BlogCategoryId { get; set; }

        [Display(Name = "Title")]
        [Required]
        [StringLength (100, MinimumLength = 2)]
        public string Title { get; set; }

        [Display(Name = "Subject")]
        [Required]
        [StringLength(50 , MinimumLength = 2)]
        public string Subject { get; set; }

        [Display(Name = "Content")]
        [StringLength(4000 , MinimumLength = 2)]
        public string Content { get; set; }
           
        [Display(Name = "Image Url")]
        [Url]
        [StringLength(255, MinimumLength=2)]
        public string ImageUrl { get; set; }
           
    }
}
