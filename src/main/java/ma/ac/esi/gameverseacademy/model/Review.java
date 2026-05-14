package ma.ac.esi.gameverseacademy.model;

import java.sql.Timestamp;

public class Review {

    private int       id;
    private int       modId;
    private String    userEmail;
    private int       rating;
    private String    comment;
    private Timestamp createdAt;

    public Review() {}

    public Review(int id, int modId, String userEmail,
                  int rating, String comment, Timestamp createdAt) {
        this.id        = id;
        this.modId     = modId;
        this.userEmail = userEmail;
        this.rating    = rating;
        this.comment   = comment;
        this.createdAt = createdAt;
    }

    // Getters
    public int       getId()        { return id;        }
    public int       getModId()     { return modId;     }
    public String    getUserEmail() { return userEmail; }
    public int       getRating()    { return rating;    }
    public String    getComment()   { return comment;   }
    public Timestamp getCreatedAt() { return createdAt; }

    // Setters
    public void setId(int id)                { this.id        = id;        }
    public void setModId(int modId)          { this.modId     = modId;     }
    public void setUserEmail(String email)   { this.userEmail = email;     }
    public void setRating(int rating)        { this.rating    = rating;    }
    public void setComment(String comment)   { this.comment   = comment;   }
    public void setCreatedAt(Timestamp t)    { this.createdAt = t;         }
}