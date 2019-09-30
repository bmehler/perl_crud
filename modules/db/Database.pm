#!/usr/bin/perl 

package Database;

use warnings;
use strict;
use DBI;
use diagnostics;
use Data::Dumper;

sub new
{
    my $class = shift;
    my $self = {
        _dbuser => 'root',
        _dbpass  => 'root',
        _dsn => 'DBI:mysql:database=test;host=localhost',
        _dbh => shift,
        _datasets => shift,
        _id => shift,
    };
    
    bless $self, $class;
    return $self;
}

sub connect {
    my ( $self, $dsn, $dbuser, $dbpass ) = @_;
    $self->{_dbh} = DBI->connect($self->{_dsn},$self->{_dbuser},$self->{_dbpass},
    { PrintError => 0,
      AutoCommit => 1,
    }
    ) or die $DBI::errstr;
    return $self->{_dbh};
}

sub createtable {
    my( $self ) = @_;
    $self->connect()->do("CREATE TABLE person (
      ID INTEGER AUTO_INCREMENT,
      name VARCHAR(20),
      vorname VARCHAR(20),
      position VARCHAR(20),
      gehalt INTEGER,
      PRIMARY KEY (ID))"
      ) or die self->connect->errstr();

      $self->connect->disconnect();
}

sub findAll {
    my( $self, $person ) = @_;
    my $sql = 'SELECT id, name, vorname, gehalt,
                CASE
                    WHEN position = 1 THEN "Projektmanager"
                    WHEN position = 2 THEN "Salesmanager"
                    WHEN position = 3 THEN "Frontend-Developer"
                    WHEN position = 4 THEN "Backend-Developer"
                    WHEN position = 5 THEN "Grafiker"
                    ELSE "nothing"
                END as position
                FROM person ORDER BY id ASC';
    my$sth = $self->connect()->prepare($sql);
    $sth->execute();
    my @all = $sth->fetchall_arrayref({});
    return @all;
}

sub findById {
    my( $self, $id ) = @_;
    my $sql = 'SELECT name, vorname, position, gehalt, id FROM person WHERE id = ?';
    my $sth = $self->connect()->prepare($sql);
    $sth->execute($id);
    $self->connect->disconnect();
    my @row_array = $sth->fetchrow_array();
    return @row_array;
}

sub add {
    my( $self, $vorname, $nachname, $position, $gehalt ) = @_;
    $self->connect()->do('INSERT INTO person (name, vorname, position, gehalt) VALUES (?, ?, ?, ?)', undef, $vorname, $nachname, $position, $gehalt);
    $self->connect->disconnect();
}

sub update {
    my( $self, $id, $vorname, $nachname, $position, $gehalt) = @_;
    $self->connect()->do('UPDATE person SET name = ?, vorname = ?, position = ?, gehalt  = ? WHERE id = ' . $id, undef, $vorname, $nachname, $position, $gehalt);
    $self->connect->disconnect();
}

sub delete {
    my( $self, $id ) = @_;
    my $sql = "DELETE FROM person WHERE id = ?";
    my $sth = $self->connect()->prepare($sql);
    $sth->execute($id);
    $self->connect->disconnect();
}
1;